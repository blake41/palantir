require 'pry'
require 'pry-nav'
index = 0
rows = 0
@columns = 0
@data = []
File.foreach("./palantir.txt").each do |line|
  if index == 0
    rows = line[0].to_i 
    columns = line[0].to_i
  else
    @data << line.chomp.strip.split("")
  end
  index+=1
end

def count_same(row, letter)
  row.count(letter) == 3 ? 1 : 0
end

def count_total_same(data)
  sum = Hash.new(0)
  ["T", "P"].each do |letter|
    data.each do |row|
      sum[letter] += count_same(row, letter)
    end
  end
  # binding.pry
  sum.sort_by {|k,v| v}.last[1]
end

def main
  highest_sames = count_total_same(@data)
  @columns.times do |number|
    sames = count_total_same(flip_column(number))
    highest_sames = sames if sames > highest_sames
  end
  highest_sames
end

def switch(letter)
  if letter == "T"
    return "P"
  else
    return "T"
  end
end

def flip_column(column_number)
  flipped_array = []
  @data.each do |row|
    new_array = []
    row.each_with_index do |letter, index|
      if index == column_number
        new_array << switch(letter)
      else
        new_array << letter
      end
    end
    flipped_array << new_array
  end
  flipped_array
end

highest_sames = main
binding.pry