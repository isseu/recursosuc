class CursosController < ApplicationController
  def index
    @cursos = Curso.all
  end
end
