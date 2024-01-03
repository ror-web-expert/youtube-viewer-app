require 'rails_helper'

RSpec.describe "Admin::GoogleAnalytics", type: :request do
  describe "GET /scrape_jobs" do
    it "returns http success" do
      get "/admin/job_analytics/scrape_jobs"
      expect(response).to have_http_status(:success)
    end
  end

end
