require "rails_helper"

RSpec.describe Item, type: :model do
  subject { item }

  let!(:item) { build(:item) }

  describe "name" do
    context "when 'name' is empty" do
      before { item.name = "" }

      it { is_expected.to be_invalid }
    end

    context "when 'name' is not empty" do
      it { is_expected.to be_valid }
    end
  end
end
