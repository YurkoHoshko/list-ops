defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count([]), do: 0
  def count([_]), do: 1
  def count([_head | tail]), do: count(tail) + 1

  # Alternative count implementation:
  # def count(l) when is_list(l), do: reduce(l, 0, fn(_v, acc) -> acc + 1 end)

  @spec reverse(list) :: list
  def reverse(l) when is_list(l) do
    reduce(l, [], fn(v, acc) -> [v | acc] end)
  end

  @spec map(list, (any -> any)) :: list
  def map([], _f), do: []
  def map([head | tail], f) when is_function(f) do
    [f.(head) | map(tail, f)]
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter([], _f), do: []
  def filter([head | tail] = l, f) when is_list(l) and is_function(f) do
    if f.(head), do: [head | filter(tail, f)], else: filter(tail, f)
  end

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce([], value, _), do: value
  def reduce([head | tail], acc, f) when is_function(f) do
    reduce(tail, f.(head, acc), f)
  end

  @spec append(list, list) :: list
  def append([], b) when is_list(b), do: b
  def append([value], b) when is_list(b), do: [value | b]
  def append([head | tail], b) when is_list(b), do: [head | append(tail, b)]

  @spec concat([[any]]) :: [any]
  def concat([]), do: []
  def concat([v]) when is_list(v), do: v
  def concat([head | tail]) when is_list(head), do: append(head, concat(tail))
end
