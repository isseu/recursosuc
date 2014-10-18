json.array!(@cursos) do |curso|
  json.extract! curso, :id, :nombre, :sigla
  json.typeahead curso.nombre + " (" + curso.sigla + ")"
end
