class School
  def initialize
    @students = {}
  end

  def to_h
    @students.sort_by { |grade, students| [grade, students.sort!] }.to_h # =>
  end

  def add(student, grade)
    @students.keys.include?(grade) ? @students[grade].push(student) : @students[grade] = [student]  
  end

  def grade(num)
    @students[num] || []
  end
end


















