module PostsHelper

  def get_tags_id
    @tags = params[:post][:tags].map do |t|
      tag = Tag.new
      tag.write_attribute(:tag, t)
      tag
    end
    @tags.map(&:save)
  end

end