defmodule Day4 do
  @moduledoc """
  Code for completing Day 4 of Advent of Code 2022
  """

  @doc """
  Returns a bool saying if one of the two ranges fully contains the other
  """
  def fully_contains?(line) do

    # first retrieve the raw ranges
    splits = String.split(line, ",")
    ranges_str = String.split(Enum.at(splits, 0), "-") ++ String.split(Enum.at(splits, 1), "-") #as strings
    ranges = ranges_str |> Enum.map(fn x -> Integer.parse(x) |> elem(0) end) #as integers

    [elem0, elem1, elem2, elem3 | _] = ranges #extract the four into individual variables

    #bot0     bot1     top0     top1       bot1     bot0     top1     top0
    (elem0 <= elem2 && elem1 >= elem3) || (elem2 <= elem0 && elem3 >= elem1)

  end

  @doc """
  Main entry point
  """
  def main do

    # first retrieve the text from the file
    {result, file} = File.read("input.txt")

    # filter out any errors
    if result == :error do
      IO.puts "Ran into an error opening the input file"
      :error
    else

      # split the file into lines
      lines = String.split(file, "\n")

      # filter all the lines
      filtered = Enum.filter(lines, &fully_contains?/1)

      # print the outputs
      IO.puts length(filtered)

      :ok
    end
  end

end

Day4.main
