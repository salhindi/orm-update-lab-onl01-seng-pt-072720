require_relative "../config/environment.rb"
require "pry"

class Student
  attr_accessor :name, :grade
  attr_reader :id
  
  def initialize(name, grade, id=nil)
    @name = name 
    @grade = grade 
    @id = id
  end
  
  def self.create_table
    sql =  <<-SQL 
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY, 
        name TEXT, 
        grade INTEGER
        )
        SQL
    DB[:conn].execute(sql) 
  end
  
  def self.drop_table 
    sql = <<-SQL
    DROP TABLE students
    SQL
    
    DB[:conn].execute(sql)
  end
   
  def save
    if self.id
      self.update
    else
      sql = <<-SQL
        INSERT INTO students (name, grade)
        VALUES (?, ?)
      SQL
        DB[:conn].execute(sql, self.name, self.grade)
        @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
    end
  end
  
<<<<<<< HEAD
  def self.create(name, grade)
=======
  def self.create(name:, grade:)
>>>>>>> a4770f61d227168521d993f3f734c96da4579693
    student = Student.new(name, grade)
    student.save
    student
  end
<<<<<<< HEAD
  
  def self.new_from_db(row)
    grade = row[0]
    id = row[1]
    name = row[2]
   
    self.new(id, name, grade)
  end
 
  def self.find_by_name(name)
    sql = "SELECT * FROM students WHERE name = ?"
    result = DB[:conn].execute(sql, name).map do |r| 
    new_from_db(r)
    end.first 
  end

  def update
    sql = "UPDATE students SET name = ?, grade = ? WHERE id = ?"
    DB[:conn].execute(sql, self.name, self.grade, self.id)
=======
 
  def self.find_by_name(name)
    sql = "SELECT * FROM students WHERE name = ?"
    result = DB[:conn].execute(sql, name)[0]
    Student.new(result[0], result[1], result[2])
  end

  def update
    sql = "UPDATE students SET name = ?, grade = ? WHERE name = ?"
    DB[:conn].execute(sql, self.name, self.grade, self.name)
>>>>>>> a4770f61d227168521d993f3f734c96da4579693
  end
end

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]



