$:.unshift(File.dirname(__FILE__))

module Contents
  module CheckHandler
    def check_contents
      Chapter.includes(:content).each do |chapter|
        logger_write "id: #{chapter.id}, url: #{chapter.url}" unless chapter.content.present?
      end
    end
  end
end