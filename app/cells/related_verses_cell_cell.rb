class RelatedVersesCellCell < TentOfMeetingCell

  def show(opts)
    @verse = Verse.find(opts[:id])
    @related = @verse.related
    render
  end

end
