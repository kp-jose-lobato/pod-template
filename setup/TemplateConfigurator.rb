require 'fileutils'
require 'colored2'

module Pod
  class TemplateConfigurator
    
    attr_reader :pod_name, :pod_type, :platform, :pods_for_podfile, :prefixes, :test_example_file, :username, :email
    
    def initialize(pod_name)
      @pod_name = pod_name
      @pod_type = ""
      @platform = ""
      @pods_for_podfile = []
      @prefixes = []
      @message_bank = MessageBank.new(self)
    end
    
    def ask(question)
      answer = ""
      loop do
        puts "\n#{question}?"
        
        @message_bank.show_prompt
        answer = gets.chomp
        
        break if answer.length > 0
        
        print "\nYou need to provide an answer."
      end
      answer
    end
    
    def ask_with_answers(question, possible_answers)
      
      print "\n#{question}? ["
      
      print_info = Proc.new {
      
      possible_answers_string = possible_answers.each_with_index do |answer, i|
        _answer = (i == 0) ? answer.underlined : answer
        print " " + _answer
        print(" /") if i != possible_answers.length-1
      end
      print " ]\n"
    }
    print_info.call
    
    answer = ""
    
    loop do
      @message_bank.show_prompt
      answer = gets.downcase.chomp
      
      answer = "yes" if answer == "y"
      answer = "no" if answer == "n"
      
      # default to first answer
      if answer == ""
        answer = possible_answers[0].downcase
        print answer.yellow
      end
      
      break if possible_answers.map { |a| a.downcase }.include? answer
      
      print "\nPossible answers are ["
      print_info.call
    end
    
    answer
  end
  
  def run
    @message_bank.welcome_message
    
    templateType = self.ask_with_answers("What kind of pod-template do you want to create", ["Feature", "Interface"]).to_sym
      @pod_type = templateType
      
      case templateType
      when :feature
        #ConfigureFeauturePod
      when :interface
        #ConfigureMidelwarePod
      else 
        puts "Sorry mate! no template yet for that option... keep trying."
      end
      
      platform = self.ask_with_answers("What platform do you want to use", ["iOS", "macOS", "tvOS"]).to_sym
        @platform = platform
        
        case platform
        when :ios, :macos
          ConfigureSwift.perform(configurator: self)
        when :tvos 
          #ConfiguretvOSSwift.perform(configurator: self)
          puts "User has selected the platform - tvOS"
        end
        
        prepare_sources_according_to_selection
        replace_variables_in_files 
        clean_template_files 
        rename_template_files 
        add_pods_to_podfile
        # We are not using the prefix for now, but it is a feaure that can be handy when developing the demo project
        # Leaving this line commented temporately.
        # customise_prefix
        delete_template_git_repo
        run_pod_install
        
        @message_bank.farewell_message
      end
      
      #----------------------------------------#
      # Action (or Steps).
      #----------------------------------------#
      
      def prepare_sources_according_to_selection
        # Step 1. Select the template (folder).
        select_sources_folder_according_to_selection
        # Step 2. Rename files and folder in the selected templater (folder).
        rename_selected_sources_folders_and_files
        # Step 3. Rename the content on every file using sustitution.
        rename_selected_sources_content
      end
      
      def select_sources_folder_according_to_selection
        # Depending on the type of template that the users selects (Feature, Flow, etc) we will choose 
        # among the available source folders (Find them at the root with the prefix `Pod-`).
        case @pod_type
        when :feature
          
          case @platform
          when :ios, :macos
            File.rename("Pod-iOS-macOS-Feature", @pod_name)
          else
            abort("Sorry mate! no template yet for that platform... keep trying.")
          end
          
        else
          abort("Sorry mate! no template yet for that option... keep trying.")
        end
        
        delete_unused_template_folders
      end

      def delete_unused_template_folders()
        # Delete all "Pod-" folders (unused templates).
        folder_to_delete_prefix = "Pod-"
        Dir.glob("#{folder_to_delete_prefix}*").each do |folder|
          if File.directory?(folder)
            FileUtils.rm_rf(folder)
          end
        end
      end
      
      def rename_selected_sources_folders_and_files
        # The selected sources templates have a bunch of files and folders with the placeholder `XVXXX`. In
        # this step we rename them to match the given name by the user.
        placeholder = "XVXXX"
        pattern = "#{@pod_name}/**/*#{placeholder}*"
        Dir.glob(pattern).each do |name|
          new_name = name.gsub(placeholder, @pod_name)
          File.rename(name, new_name)
        end
      end
      
      def rename_selected_sources_content
        # Once the template is selected and the folders has been rename we need to rename the content of the
        # template files.
        pattern = "#{@pod_name}/**/*"
        Dir.glob(pattern).each do |path|
          replace_file_content(path) if File.file?(path)
        end
        
      end
      
      def run_pod_install
        puts "\nRunning " + "pod install".magenta + " on your new library."
        puts ""
        
        Dir.chdir("Example") do
          system "pod install"
        end
        
      end
      
      def clean_template_files
        ["./**/.gitkeep", "configure", "_CONFIGURE.rb", "README.md", "LICENSE", "templates", "setup", "CODE_OF_CONDUCT.md", ".gitignore"].each do |asset|
          `rm -rf #{asset}`
        end
      end
      
      def replace_variables_in_files
        file_names = ['POD_README.md', 'NAME.podspec', podfile_path, 'CuckooMockGenerator.sh']
        file_names.each do |file_name|
          replace_file_content(file_name)
        end
      end
      
      def replace_file_content(file_name)
        puts "file name: #{file_name}"
        text = File.read(file_name)
        text.gsub!("${POD_NAME}", @pod_name)
        text.gsub!("XVXXX", @pod_name)
        text.gsub!("${POD_TYPE}", @pod_type.to_s)
        # text.gsub!("${REPO_NAME}", @pod_name.gsub('+', '-'))
        # text.gsub!("${USER_NAME}", user_name)
        # text.gsub!("${USER_EMAIL}", user_email)
        # text.gsub!("${YEAR}", year)
        # text.gsub!("${DATE}", date)
        File.open(file_name, "w") { |file| file.puts text }
      end
      
      def add_pod_to_podfile podname
        @pods_for_podfile << podname
      end
      
      def add_pods_to_podfile
        podfile = File.read podfile_path
        podfile_content = @pods_for_podfile.map do |pod|
          "pod '" + pod + "'"
        end.join("\n    ")
        podfile.gsub!("${INCLUDED_PODS}", podfile_content)
        File.open(podfile_path, "w") { |file| file.puts podfile }
      end
      
      def add_line_to_pch line
        @prefixes << line
      end
      
      def customise_prefix
        prefix_path = "Example/Tests/Tests-Prefix.pch"
        return unless File.exist? prefix_path
        
        pch = File.read prefix_path
        pch.gsub!("${INCLUDED_PREFIXES}", @prefixes.join("\n  ") )
        File.open(prefix_path, "w") { |file| file.puts pch }
      end
      
      def set_test_framework(test_type, extension, folder)
        content_path = "setup/test_examples/" + test_type + "." + extension
        tests_path = "templates/" + folder + "/Example/Tests/Tests." + extension
        tests = File.read tests_path
        tests.gsub!("${TEST_EXAMPLE}", File.read(content_path) )
        File.open(tests_path, "w") { |file| file.puts tests }
      end
      
      def rename_template_files
        FileUtils.mv "POD_README.md", "README.md"
        FileUtils.mv "NAME.podspec", "#{pod_name}.podspec"
      end
      
      
      def delete_template_git_repo
        `rm -rf .git`
      end
      
      def validate_user_details
        return (user_email.length > 0) && (user_name.length > 0)
      end
      
      #----------------------------------------#
      # Accessory methods to collect data.
      #----------------------------------------#
      
      def user_name
        (ENV['GIT_COMMITTER_NAME'] || github_user_name || `git config user.name` || `<GITHUB_USERNAME>` ).strip
      end
      
      def github_user_name
        github_user_name = `security find-internet-password -s github.com | grep acct | sed 's/"acct"<blob>="//g' | sed 's/"//g'`.strip
        is_valid = github_user_name.empty? or github_user_name.include? '@'
        return is_valid ? nil : github_user_name
      end
      
      def user_email
        (ENV['GIT_COMMITTER_EMAIL'] || `git config user.email`).strip
      end
      
      # def year
      #   Time.now.year.to_s
      # end
      
      # def date
      #   Time.now.strftime "%m/%d/%Y"
      # end
      
      def podfile_path
        'Example/Podfile'
      end
      
      #----------------------------------------#
    end
  end
  