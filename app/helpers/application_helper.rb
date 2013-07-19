module ApplicationHelper

	#return title for each page
	def full_title(page_title)
		base_title = "UMich Startups"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end

end
