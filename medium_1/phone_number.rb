=begin 
P: Write a class that will parse a given phone number, return it with 
the number method, return the first three digits with the area_code method,
return a string with area code in brackets with number.to_s
E: see tests

D: I: A string with numbers, brackets, symbols etc.
  O: A string.

A: -// new

   -// number
   = will parse the string and validate it according to these rules:
    If the phone number is less than 10 digits assume that it is bad number
    If the phone number is 10 digits assume that it is good
    If the phone number is 11 digits and the first number is 1, trim the 1 and use the last 10 digits
    If the phone number is 11 digits and the first number is not 1, then it is a bad number
    If the phone number is more than 11 digits assume that it is a bad number

   = will return a new Phonenumber instance with the correct formatting

   -// to_s
   =Defined for instances of a Phonenumber
   =Will output the number in the format (xxx) xxx-xxxx
    
=end

INVALID = '0000000000'
class PhoneNumber 
  def initialize(number_str)
    @valid_num = parse(number_str)
  end

  def parse(number_str)
    number_str.gsub!(/[\-\.\(\) )]/, '')
    parsed_number = case
                    when (number_str.match /[^0-9]/)
                      INVALID
                    when number_str.length == 10
                      number_str
                    when number_str.length == 11
                      number_str.start_with?('1') ? number_str[1..-1] : INVALID
                    else
                      INVALID
                    end
  end

  def number
    @valid_num
  end

  def area_code
    @valid_num[0..2]
  end

  def to_s
    "(#{area_code}) #{@valid_num[3..5]}-#{@valid_num[6..-1]}"
  end
end