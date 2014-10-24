class CursosController < ApplicationController
  before_action :set_archivo, only: [:show]
  def index
    @cursos = Curso.all

  end

  def show
    @archivos = Archivo.where(:curso => @curso)
  end

  private

  def set_archivo
    if params[:id] and params[:id] =~ /^\d+$/
      @curso = Curso.find(params[:id])
    else
      redirect_to root_path
    end
  end
end
