from src.py.main import hello


def test_hello():
    assert hello("Agent") == "Hello, Agent!"
