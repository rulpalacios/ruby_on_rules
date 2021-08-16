require "rulers/version"
require "rulers/routing"
require "rulers/util"
require "rulers/dependencies"
require "rulers/controller"

module Rulers
  class Application
    def call(env)
      if env['PATH_INFO'] == '/favicon.ico'
        return [404,
          {'Content-Type' => 'text/html'}, []]
      end
      klass, act = get_controller_and_action(env)
      controller = klass.new(env)
      text = controller.send(act)
      [200, {'Content-Type' => 'text/html'},
        [text]]
    end
  end
  
  class Controller
    def controller_name
      self.class
    end

    def user_agent
      @env[]
    end
    def request_start_time
      # Note: for this, you’ll
      # need to set @start_time
      # to Time.now at the beginning
      # of Application#call().
      @start_time
    end
    def rulers_version
      Rulers::VERSION
    end
  end

end
