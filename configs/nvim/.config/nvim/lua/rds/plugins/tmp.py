def my_func_with_args_and_kwargs(*args, **kwargs) -> bool:
    return False


def my_func_with_args_and_kwargs(*args, **kwargs) -> None:
    ...


def my_func_without_args():
    ...


def my_func(a: int) -> bool:
    def my_inner_func(b: int, c) -> None:
        ...

    return False

if True:
    pass
