qcd() {
  case "$1" in
    p)
      cd $HOME/Documents/projects/git/personal
      ;;
    b)
      cd $HOME/Documents/projects/git/business
      ;;
    *)
      echo "qcd: unknown key $1"
      return 1
    ;;
  esac
    pwd
}
