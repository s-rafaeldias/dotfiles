from typing import List, Tuple

def my_func_with_args_and_kwargs(*args, **kwargs) -> bool:
    return False


def my_func_with_args_and_kwargs3(*args, **kwargs) -> List[bool]:
    return [False]


def my_func_with_args_and_kwargs2(*args, **kwargs) -> None:
    ...


def my_func_without_args():
    ...

def foo() -> Tuple[bool, int]:
    return True, 1

def my_func(a: int) -> bool:
    ...

    def my_inner_func(b: int, c) -> None:
        ...

    return False


if True:
    pass
