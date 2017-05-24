# coding: utf-8

module Soseol
  def convert(line)
    line
  end

  class Converting
    attr_accessor :kind_of_line, :simple_variables, :array_variables
    attr_accessor :split_line
    attr_accessor :simple_variables_count, :array_variables_count
    attr_accessor :output_word

    def initiallize
      @split_line = []
      @simple_variables = {}
      @array_variables = {}
      @simple_variables_count = 0
      @array_variables_count = 0
      @output_word = " "
    end

    def make_split_line(line)
      @output_word = ""
      @split_line = line.split(" ")

      reconize_pattern
      print_information
      extract_important_values
    end


    def reconize_pattern
      postfix_word = []
      if @split_line.count == 2
        if @split_line[0].include?("는") & @split_line[1].include?("야")
          simple_varibles_pattern
        end
      elsif @split_line[0].include?("에는") | @split_line.last.include?("있어")
        array_variables_pattern
      else
      end
    end

    def simple_varibles_pattern
      variable_name = @split_line[0].delete("는").to_s
      variable_value = @split_line[1].delete("야")
      new_val = "x"+@simple_variables_count.to_s
      @simple_variables[new_val] = variable_name
      @simple_variables_count += 1
      if variable_value.to_i != 0
        @output_word = new_val.to_s + ' = ' + variable_value  + "\n"
      else
        @output_word = new_val.to_s + '= "' + variable_value + '" ' "\n"
      end
    end

    def array_variables_pattern
      variable_name = @split_line[0].delete("에는").to_s

      puts variable_name
      var_num = 0
      @split_line.each do |line|
        if line.include?("랑")
          var_num += 1
        end
      end
      val_value = []
      for i in (1..var_num)
        value = @split_line[i].delete("랑").to_s
        val_value << value
      end

      val_value << @split_line[@split_line.count-2].delete("가").to_s
      new_val = "a"+@array_variables_count.to_s
      @array_variables[new_val] = variable_name
      @output_word = new_val.to_s + " = ["
      val_value.each do |char|
        if char.to_i != 0
          @output_word += (char +",")
        else
          @output_word += '"' + char + '",'
        end
      end
        @output_word.chop!
        @output_word += "]\n"

      @array_variables_count += 1
    end

    def extract_important_values
      @split_line = []
    end

    def print_output_word
      @output_word
    end



    def print_information
      puts "split_line : "
      puts @split_line
      puts "kind_of_line : "
      puts @kind_of_line
      puts "variables : "
      puts  @simple_variables
    end
  end
end
