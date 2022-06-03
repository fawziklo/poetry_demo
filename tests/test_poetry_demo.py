from poetry_demo import __version__
from poetry_demo import poetry_demo


def test_version():
    assert __version__ == "0.1.0"


def test_add():
    assert 2 == poetry_demo.add(1, 1)
