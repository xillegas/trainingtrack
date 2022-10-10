# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Seeds"

print "\rDestruyendo conuco %1..."
Job.destroy_all
print "\rDestruyendo conuco %2..."
Muscle.destroy_all
print "\rDestruyendo conuco %3..."
Group.destroy_all
print "\rDestruyendo conuco %4..."
Work.destroy_all
Exercise.destroy_all

ActiveRecord::Base.connection.reset_pk_sequence!("jobs")
ActiveRecord::Base.connection.reset_pk_sequence!("muscles")
ActiveRecord::Base.connection.reset_pk_sequence!("exercises")
ActiveRecord::Base.connection.reset_pk_sequence!("groups")

print "\rCreando Cuerpos    %9..."
pierna =  Group.create(name:"Piernas")
espalda = Group.create(name:"Espalda")
core =    Group.create(name:"Core")
brazos =  Group.create(name:"Brazos")
superior = Group.create(name:"Superior")
print "\rCreando Músculos   %10..."
Muscle.create(name:"Pectorales", group: superior)
Muscle.create(name:"Cuello", group: superior)
Muscle.create(name:"Deltoides", group: superior)
Muscle.create(name:"Triceps", group: brazos)
Muscle.create(name:"Biceps", group: brazos)
Muscle.create(name:"Antebrazos", group: brazos)
Muscle.create(name:"Abdominales", group: core)
Muscle.create(name:"Obliques", group: core)
print "\rCreando Músculos   %15..."
Muscle.create(name:"Intercostales", group: core)
Muscle.create(name:"Trapecio", group: espalda)
Muscle.create(name:"Lats", group: espalda)
Muscle.create(name:"Espalda baja", group: espalda)
Muscle.create(name:"Quadriceps", group: pierna)
Muscle.create(name:"Gluteos", group: pierna)
Muscle.create(name:"Muslo anterior", group: pierna)
print "\rCreando Músculos   %20..."
Muscle.create(name:"Canilla", group: pierna)

#################################
print "\rCreando Ejercicios %22..."
push_up = Exercise.create(name:"Push up", difficulty: 1)
Job.create(exercise: push_up, muscle: Muscle.find_by(name: "Pectorales"), intensity: 33)
Job.create(exercise: push_up, muscle: Muscle.find_by(name: "Triceps"), intensity: 30)
Job.create(exercise: push_up, muscle: Muscle.find_by(name: "Deltoides"), intensity: 20)
Job.create(exercise: push_up, muscle: Muscle.find_by(name: "Abdominales"), intensity: 17)
print "\rCreando Ejercicios %44..."
pull_up = Exercise.create(name:"Pull up", difficulty: 1)
Job.create(exercise: pull_up, muscle: Muscle.find_by(name: "Lats"), intensity: 40)
Job.create(exercise: pull_up, muscle: Muscle.find_by(name: "Biceps"), intensity: 40)
Job.create(exercise: pull_up, muscle: Muscle.find_by(name: "Antebrazos"), intensity: 20)
print "\rCreando Ejercicios %66..."
sits = Exercise.create(name:"Sentadillas", difficulty: 1)
Job.create(exercise: sits, muscle: Muscle.find_by(name:"Abdominales"), intensity: 90)
Job.create(exercise: sits, muscle: Muscle.find_by(name:"Obliques"), intensity: 10)
print "\rCreando Ejercicios %88..."
m_press = Exercise.create(name:"Military Press", difficulty: 1.5)
Job.create(exercise: m_press, muscle: Muscle.find_by(name:"Deltoides"), intensity: 30)
Job.create(exercise: m_press, muscle: Muscle.find_by(name:"Triceps"), intensity: 70)
print "\rCreando Ejercicios %99..."
bar = Exercise.create(name:"Barra sin peso", difficulty: 0.5)
Job.create(exercise: bar, muscle: Muscle.find_by(name:"Biceps"), intensity:90)
Job.create(exercise: bar, muscle: Muscle.find_by(name:"Deltoides"), intensity:10)
###
Work.create(exercise: m_press, set: 2, rep: 2)
Work.create(exercise: sits, set: 2, rep: 2)
Work.create(exercise: push_up, set: 2, rep: 2)
Work.create(exercise: pull_up, set: 3, rep: 3)
Work.create(exercise: bar, set: 3, rep: 30)
print "\rCreando Ejercicios %100..."
puts ""
puts "Semillas germinando..."
