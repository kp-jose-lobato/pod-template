module Pod

  class ConfigureSwift
    attr_reader :configurator

    def self.perform(options)
      new(options).perform
    end

    def initialize(options)
      @configurator = options.fetch(:configurator)
    end

    def perform
      # For simplicty this template always includes a demo project.
      # keep_demo = configurator.ask_with_answers("Would you like to include a demo application with your library", ["Yes", "No"]).to_sym
      keep_demo = "Yes".to_sym

      Pod::ProjectManipulator.new({
        :configurator => @configurator,
        :xcodeproj_path => "templates/swiftui/Example/PROJECT.xcodeproj",
        :platform => :ios,
        :remove_demo_project => (keep_demo == :no),
        :prefix => ""
      }).run

      pod_type =

      case @configurator.pod_type
      when :feature
        puts "  Configuring dependencies in a feature pod"
        configurator.add_pod_to_podfile "XVAsset"
        configurator.add_pod_to_podfile "UIFramework"
        configurator.add_pod_to_podfile "KPAnalyticsInterface"
        configurator.add_pod_to_podfile "XVCoordinationRequest"
        configurator.add_pod_to_podfile "XVEntities"
        
      when :interface
        puts "  Configuring dependencies in an interface pod"
        configurator.add_pod_to_podfile "XVEntities"

      else
        puts "  Unknown pod type to configure"
      end

      # Move the Example folder to the root
      `mv ./templates/swiftui/* ./`

    end
  end

end
