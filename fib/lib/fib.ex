defmodule Fib do
  defdelegate fib(n), to: Fib.CacheFib
end
