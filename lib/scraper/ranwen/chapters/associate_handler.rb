module Chapters
  module AssociateHandler
    def parse_chapter_associate
      Book.all.each do |book|
        next unless book.last_chapter.present?
        associate_next_chapter book.last_chapter
      end
    end

    def associate_next_chapter chapter
      return if chapter.parent_id.to_i == 0

      parent_chapter = Chapter.find_by_id(chapter.parent_id)
      parent_chapter.next_id = chapter.id
      parent_chapter.save!

      associate_next_chapter parent_chapter
    end
  end
end