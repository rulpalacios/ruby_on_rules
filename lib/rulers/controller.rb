module Rulers
  class Controller
    def initialize(env)
      @env = env 
    end

    def env 
      @env
    end 

    def instance_vars
      vars = {}
      instance_variables.each do |name|
        vars[name[1..-1]] = instance_variable_get name.to_sym
      end

      vars 
    end

    def render(view_name, locals = instance_vars)
      filename = File.join "app", "views",  "#{view_name}.html.erb"
      template = File.read filename
      eruby = Erubis::Eruby.new(template)
      eruby.result locals.merge(:env => env)
    end
  end
end