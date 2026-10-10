{ pkgs, ... }:
let
  py = pkgs.python3Packages;

  # SQL Server 用アダプタ (nixpkgs 未収録のため PyPI の wheel から作る)
  harlequin-odbc = py.buildPythonPackage rec {
    pname = "harlequin_odbc";
    version = "0.4.0";
    format = "wheel";
    src = py.fetchPypi {
      inherit pname version format;
      dist = "py3";
      python = "py3";
      hash = "sha256-V/IUHQ2K+3aCOUJw8RzjG+++9kf3B6ElaUxqLLYQ3WY=";
    };
    dependencies = [ py.pyodbc ];
    # harlequin 本体は下の override で同じ環境に入るので、ここではチェックしない
    pythonRemoveDeps = [ "harlequin" ];
    dontCheckRuntimeDeps = true;
    doCheck = false;
  };

  msodbcsql18 = pkgs.unixodbcDrivers.msodbcsql18;

  # pyodbc (unixODBC) が Microsoft ODBC Driver 18 を名前で引けるようにする
  odbcsysini = pkgs.writeTextDir "odbcinst.ini" ''
    [${msodbcsql18.fancyName}]
    Description = ${msodbcsql18.meta.description}
    Driver = ${msodbcsql18}/${msodbcsql18.driver}
  '';

  # PostgreSQL / SQLite は本体に同梱。SQL Server 用に odbc アダプタを追加する
  harlequin = pkgs.harlequin.overridePythonAttrs (old: {
    dependencies = (old.dependencies or [ ]) ++ [ harlequin-odbc ];
    # odbc アダプタはオプションを持たないため「全アダプタにオプションがある」前提のテストが落ちる
    disabledTests = (old.disabledTests or [ ]) ++ [ "test_spec_covers_every_installed_adapter" ];
    makeWrapperArgs = (old.makeWrapperArgs or [ ]) ++ [
      "--set-default" "ODBCSYSINI" "${odbcsysini}"
      # ドライバは OpenSSL を /opt/homebrew/opt/openssl/lib などから dlopen するため、Nix の OpenSSL 3 を渡す
      # 他の依存 (libcurl 等) と同じ libssl.3 を使わないとシンボル不一致で落ちるので pkgs.openssl に揃える
      "--prefix" "DYLD_LIBRARY_PATH" ":" "${pkgs.openssl.out}/lib"
    ];
  });
in
{
  home.packages = [ harlequin ];
}
