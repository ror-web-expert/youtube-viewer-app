require 'rails_helper'

describe PostScraperService do
  describe '#filter_by_title' do
    context 'when filtering post titles' do
      let(:specialities) { Speciality_List }

      Post.scraped.each do |post|
        it 'updates is_scrap for posts with matching specialities' do
          scrapper = PostScraperService.new(post)
          matching_specialities = scrapper.filter_by_title(post.title)
          response_data_specialities = post.response_data&.fetch('specialities', '')
          post.update!(is_scrap: false) if post.response_data['specialities'] != matching_specialities
          expect(response_data_specialities).to eq(matching_specialities)
        end
      end
    end
  end
end
