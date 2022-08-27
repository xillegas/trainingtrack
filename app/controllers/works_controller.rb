class WorksController < ApplicationController
  def index
    tracks = Work.all
    # Se puede recorrer toda la base de datos: Work.first.exercise.jobs.first.muscle.group
    @work_by_group = {}
    tracks.each do |track|
      track.exercise.jobs.each do |effort|
          print "HOLAAAAAAAAAAAAAAAAAAAAAAAAAAA"
          nombre = effort.muscle.group.name
          print(nombre)
          @work_by_group[nombre] = @work_by_group[nombre].to_i + effort.intensity.to_i #* effort.exercise.difficulty
      end
    end
    return @work_by_group
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
