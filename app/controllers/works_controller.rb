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
    @work = Work.new
    @exercise = Exercise.find(params[:exercise_id])
  end

  def create
    @work = Work.new(work_params)
    @work.save

    redirect_to works_path(@work)
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def works_params
    params.require(:works).permit(:name)
  end
end
