class ArchivosController < ApplicationController
  authorize_resource
  before_action :set_archivo, only: [:show, :update, :edit, :destroy, :descargar]

  def index
    @archivos = Archivo.all
  end

  def edit
    if @archivo.update(update_params)
      redirect_to @archivo, notice: 'Archivo fue actualizado correctamente.'
    else
      render :edit
    end
  end

  def update
  end

  def destroy
    @archivo.destroy
    redirect_to root_url, notice: 'Archivo fue eliminado correctamente.'
  end

  def create
    @archivo = Archivo.new(archivo_params)
    if @archivo.save
      redirect_to @archivo, notice: 'Archivo fue creado correctamente'
    else
      render :new
    end
  end

  def new
    @archivo = Archivo.new
  end

  def show
  end

  def descargar
    send_file @archivo.documento.path,
              :filename => @archivo.documento_file_name,
              :type => @archivo.documento_content_type,
              :disposition => 'attachment'
  end

  private
    def set_archivo
      if params[:id] and params[:id] =~ /^\d+$/
        @archivo = Archivo.find(params[:id])
      else
        redirect_to root_path
      end
    end
    def update_params
      params.require(:archivo).permit(:documento, :titulo, :descripcion)
    end
    def archivo_params
      params.require(:archivo).permit(:documento, :titulo, :descripcion)
    end
end
