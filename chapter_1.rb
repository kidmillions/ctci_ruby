# 1.1 Implement an algorithm to determine if a string has all unique characters
# 1.3 Write a method to determine if one string is a permutation of another.
# 1.5 Compress string, return original string if longer
# 1.7 Set entire columns and rows to 0 if given value in matrix is zero
# 1.8 check to see of one string is the rotation of another


require 'stringio'
require 'matrix'

class String
  def is_all_uniq?
    vals = Hash.new(false)
    chars.each do |c|
      if vals[c]
        return false
      else
        vals[c] = true
      end
    end
    return true
  end

  def is_permutation?(str)
    #assemble hash maps of each string
    if length != str.length
      return false
    end

    str_hash = Hash.new(0)
    str_2_hash = Hash.new(0)

    chars.each do |c|
      str_hash[c] += 1
    end

    str.chars.each do |c|
      str_2_hash[c] += 1
    end


    # compare hash key value amounts
    str_hash.eql?(str_2_hash)

  end

  def compress
    str = ''
    count = 1
    chars.each_with_index do |c, i|
      if c == chars[i + 1]
        count += 1
      else
        str += c + count.to_s
        count = 1
      end
    end

    if str.length <= length
      return str
    else
      return self
    end
  end

  def compress_better
    # Using Ruby's 'string buffer' style StringIO class
    str = StringIO.new
    count = 1
    chars.each_with_index do |c, i|
      if c == chars[i+1]
        count += 1
      else
        str.write(c)
        str.write(count)
        count = 1
      end
    end

    if str.length <= length
      str.string
    else
      self
    end
  end

  def is_rotated?(str)
    if (length == str.length && length > 0)
      test_string = self + self
      return test_string.include?(str)
    else
      return false
    end
  end

end


class Matrix
  def set_zeroes
      rows = Array.new(row_count, false)
      columns = Array.new(column_count, false)


      each_with_index do |e, row, col|
        if e == 0
          rows[row] = true
          columns[col] = true
        end
      end

      mat = to_a

      mat.each_with_index do |row, i|
        row.collect!.with_index do |item, j|
          if (rows[i] || columns[j])
            0
          else
            item
          end
        end
      end


      Matrix[mat]
  end
end
