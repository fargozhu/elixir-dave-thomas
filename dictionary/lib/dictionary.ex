defmodule Dictionary do

  def random_word do
    words_list()
    |> Enum.random()
  end

  def words_list do
    "../assets/words.txt"
    |> Path.expand(__DIR__)
    |> File.read!()
    |> String.split(~r/\n/)
  end
end
