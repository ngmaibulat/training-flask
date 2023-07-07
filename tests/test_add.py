from ngmapi.func import add


def test_add():
    # Test case 1
    result = add(2, 3)
    assert result == 5, "Expected 5"

    # Test case 2
    result = add(-10, 10)
    assert result == 0, "Expected 0"

    # Test case 3
    result = add(0, 0)
    assert result == 0, "Expected 0"
