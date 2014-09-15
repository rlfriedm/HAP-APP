require 'spec_helper'

describe "HapApps" do
  describe "GET /hap_apps" do
    it "display users" do
    		visit task_path
    			page.should have_content 'zarnold'
    end
  end
end
