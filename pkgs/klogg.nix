{
  lib,
  stdenv,
  version ? "24.11.0",
  rev ? "25c7de6d8f6da2ce6a00882e5af70b4f331af4c5",
  fetchFromGitHub,
  libsForQt5,
  cmake,
  pkg-config,
  libuchardet,
  hyperscan,
  xxHash,
  onetbb,
  python3,
  ragel,
  boost,
}:
let
  libqt = libsForQt5;
  qt = libqt.qt5;
in
stdenv.mkDerivation {
  pname = "klogg";
  inherit version;
  qmakeFlags = [ "VERSION=${version}" ];

  src = fetchFromGitHub {
    owner = "variar";
    repo = "klogg";
    inherit rev;
  };

  nativeBuildInputs = [
    cmake
    pkg-config
    qt.wrapQtAppsHook

    libqt.karchive
    libuchardet
    hyperscan
    xxHash
  ];

  buildInputs = [
    qt.qtbase
    onetbb
    python3
    ragel
    boost
  ];

  meta = with lib; {
    description = "The faster, smart log explorer";
    longDescription = ''
      Klogg is a multi-platform GUI application that helps browse and search
      through long and complex log files. It is designed with programmers and
      system administrators in mind and can be seen as a graphical, interactive
      combination of grep, less, and tail.
    '';
    homepage = "https://klogg.filimonov.dev/";
    license = licenses.gpl3Plus;
    platforms = platforms.unix;
  };
}
