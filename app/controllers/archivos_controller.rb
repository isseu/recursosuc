class ArchivosController < ApplicationController
  authorize_resource
  before_action :set_archivo, only: [:show, :update, :edit, :destroy, :descargar]

  def index
    if not params[:busqueda].nil?
      if params[:busqueda] == ''
        redirect_to root_url
      else
        # sacamos cosas clave
        @archivos = Archivo.buscar(params[:busqueda])
        render :buscar
      end
    end
    @archivos = Archivo.all.order(created_at: :desc).limit(20)
    @archivos2 = Archivo.all.order(descargas: :desc).limit(20)
  end

  def edit
  end

  def update
    if @archivo.update(update_params)
      redirect_to @archivo, notice: 'Archivo fue actualizado correctamente.'
    else
      render :edit
    end
  end

  def destroy
    @archivo.destroy
    redirect_to root_url, notice: 'Archivo fue eliminado correctamente.'
  end

  def create
    @archivo = Archivo.new(archivo_params)
    @archivo.user = current_user
    @archivo.profesor = @archivo.profesor.titleize # a mayusculas y mas bonito

    # verificamos que no exista el archivo
    buscarSiExiste = Archivo.where(documento_fingerprint: @archivo.documento_fingerprint).take
    if not buscarSiExiste.nil?
      flash[:notice] = "Este archivo #{view_context.link_to('ya existe', buscarSiExiste)} en la base de datos.".html_safe
      render :new
      return
    end

    match = /(?<curso>.+) \( (?<sigla>.+) \)/.match(params[:archivo][:curso])
    if match.nil?
      flash[:notice] = 'Curso o sigla invalidos'
      render :new
      return
    end

    @archivo.curso = Curso.where(nombre: match['curso'].mb_chars.upcase, sigla: match['sigla'].upcase).first

    if @archivo.curso.nil?
      flash[:notice] = 'Curso o sigla invalidos'
      render :new
      return
    end

    if @archivo.save
      redirect_to @archivo, notice: 'Archivo fue creado correctamente.'
    else
      flash[:notice] = 'Error al guardar el archivo: ' + @archivo.errors.full_messages.join(", ")
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
    @archivo.descargas += 1;
    @archivo.save!
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
      params.require(:archivo).permit(:documento, :ano, :semestre, :tipo, :profesor)
    end

    def archivo_params
      params.require(:archivo).permit(:documento, :ano, :semestre, :tipo, :profesor)
    end
end
