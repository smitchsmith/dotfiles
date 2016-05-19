class Employee
  attr_reader :name, :title, :salary, :boss

  def initialize(name, title, salary, boss)
    @name, @title, @salary, @boss =
      name, title, salary, boss
  end

  def bonus(multiplier)
    @salary * multiplier
  end

end

class Manager < Employee

  attr_reader :employees

  def initialize(name, title, salary, boss, employees)
    super(name, title, salary, boss)
    @employees = employees
  end

  def bonus(multiplier)
    total_salary * multiplier
  end

  def total_salary
    total_salary = 0
    @employees.each do |employee|
      total_salary += employee.salary
      if employee.is_a?(Manager)
        sub_employee_salaries = employee.total_salary
        total_salary += sub_employee_salaries
      end
    end

    total_salary
  end

end