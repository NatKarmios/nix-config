{
  buildPythonPackage,
  fetchPypi,
  setuptools,
  wheel,
}:

buildPythonPackage rec {
  pname = "pytermtk";
  version = "0.50.0a0";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-RgM0D28/pQJbFzU9QcFS4iOv2Xrz00O4tzyBw5DK7i8=";
  };

  # do not run tests
  doCheck = false;

  # specific to buildPythonPackage, see its reference
  pyproject = true;
  build-system = [
    setuptools
    wheel
  ];

  dependencies = [
  ];
}

