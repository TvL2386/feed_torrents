require 'spec_helper'
require 'feed_torrents'

describe FeedTorrents do
  it "should have a VERSION constant" do
    subject.const_get('VERSION').should_not be_empty
  end
end
