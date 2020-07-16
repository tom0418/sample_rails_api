require "rails_helper"

RSpec.describe Todo, type: :model do
  subject { todo }

  let!(:todo) { build(:todo) }

  describe "association" do
    let!(:todo) { create(:todo, :with_default_items) }

    context "when 'todo' is deleted" do
      it "related 'items' are deleted" do
        expect { todo.destroy }.to change(Item, :count).by(-1)
      end
    end
  end

  describe "title" do
    context "when 'title' is empty" do
      before { todo.title = "" }

      it { is_expected.to be_invalid }
    end

    context "when 'title' is not empty" do
      it { is_expected.to be_valid }
    end
  end

  describe "created_by" do
    context "when 'created_by' is empty" do
      before { todo.created_by = "" }

      it { is_expected.to be_invalid }
    end

    context "when 'created_by' is not empty" do
      it { is_expected.to be_valid }
    end
  end
end
