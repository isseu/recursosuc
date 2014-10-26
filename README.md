README
======
Recursos UC es hecha en rails para compartir y organizar
pruebas y interrogaciones para la carrera de ingeniería.

## Instalación

Configurar servidor smtp en archivo enviroments para confirmación via email.
```ruby
  config.action_mailer.smtp_settings = {
      address:              '<servidor smtp>',
      port:                 587,
      domain:               '<dominio>',
      user_name:            '<username>',
      password:             '<password>',
      authentication:       'plain',
      enable_starttls_auto: true
  }
```
Seedear la base de datos con `rake db:seed`.


El usuario y contraseña por defecto es `ejcorrea@uc.cl` - `mamamia123`. Debe
ser cambiado inmediatamente en `http://sitio/users/edit`.
