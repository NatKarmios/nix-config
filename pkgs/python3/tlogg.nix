{
  buildPythonPackage,
  fetchPypi,
  setuptools,
  wheel,
  pytermtk,
  appdirs,
  copykitten,
  pyyaml,
  pygments,
}:

buildPythonPackage rec {
  pname = "tlogg";
  version = "0.48.2a0";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-eY96MwbbytQ7URVezvnNmGhwoXlUGCuW3juJjdqz6D4=";
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
    pytermtk
    appdirs
    copykitten
    pyyaml
    pygments
  ];
}
