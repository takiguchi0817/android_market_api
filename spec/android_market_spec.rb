# -*- coding: utf-8 -*-
require 'spec_helper'

describe AndroidMarket do
  describe "#get_application_categories" do
    subject { AndroidMarket.get_application_categories }

    it{ should have_at_least(1).items }
    it{ should include "BOOKS_AND_REFERENCE" }
  end

  describe "#get_languages" do
    subject { AndroidMarket.get_languages }

    it{ should have_at_least(1).items }
    it{ should include "en" }
  end

  describe "#get_game_categories" do
    subject { AndroidMarket.get_game_categories }

    it{ should have_at_least(1).items }
    it{ should include "ARCADE" }
  end

  let(:category) { "BOOKS_AND_REFERENCE" }
  let(:position) { 1 }
  let(:language) { "en" }
  let(:developer_name) { "Google Inc." }

  shared_examples_for :android_market_base_examples do
    describe "#get_top_selling_free_app_in_category" do
      subject { AndroidMarket.get_top_selling_free_app_in_category(category, position, language) }

      it{ should be_an_instance_of AndroidMarketApplication }
    end

    describe "#get_top_selling_paid_app_in_category" do
      subject { AndroidMarket.get_top_selling_paid_app_in_category(category, position, language) }

      it{ should be_an_instance_of AndroidMarketApplication }
    end

    describe "#get_overall_top_selling_free_app" do
      subject { AndroidMarket.get_overall_top_selling_free_app(position, language) }

      it{ should be_an_instance_of AndroidMarketApplication }
    end

    describe "#get_overall_top_selling_paid_app" do
      subject { AndroidMarket.get_overall_top_selling_paid_app(position, language) }

      it{ should be_an_instance_of AndroidMarketApplication }
    end

    describe "#get_overall_top_selling_new_paid_app" do
      subject { AndroidMarket.get_overall_top_selling_new_paid_app(position, language) }

      it{ should be_an_instance_of AndroidMarketApplication }
    end

    describe "#get_overall_top_selling_new_free_app" do
      subject { AndroidMarket.get_overall_top_selling_new_free_app(position, language) }

      it{ should be_an_instance_of AndroidMarketApplication }
    end

    describe "#get_developer_app_list" do
      subject { AndroidMarket.get_developer_app_list(developer_name, position, language) }

      it{ should array_instance_of AndroidMarketApplication }
    end

    describe "#get_top_selling_free_apps_in_category" do
      subject { AndroidMarket.get_top_selling_free_apps_in_category(category, position, language) }

      it{ should array_instance_of AndroidMarketApplication }
    end

    describe "#get_top_selling_paid_apps_in_category" do
      subject { AndroidMarket.get_top_selling_paid_apps_in_category(category, position, language) }

      it{ should array_instance_of AndroidMarketApplication }
    end

    describe "#get_overall_top_selling_free_apps" do
      subject { AndroidMarket.get_overall_top_selling_free_apps(position, language) }

      it{ should array_instance_of AndroidMarketApplication }
    end

    describe "#get_overall_top_selling_paid_apps" do
      subject { AndroidMarket.get_overall_top_selling_paid_apps(position, language) }

      it{ should array_instance_of AndroidMarketApplication }
    end

    describe "#get_overall_top_grossing_apps" do
      subject { AndroidMarket.get_overall_top_grossing_apps(position, language) }

      it{ should array_instance_of AndroidMarketApplication }
    end

    describe "#get_overall_top_selling_new_paid_apps" do
      subject { AndroidMarket.get_overall_top_selling_new_paid_apps(position, language) }

      it{ should array_instance_of AndroidMarketApplication }
    end

    describe "#get_overall_top_selling_new_free_apps" do
      subject { AndroidMarket.get_overall_top_selling_new_free_apps(position, language) }

      it{ should array_instance_of AndroidMarketApplication }
    end

    describe "#get_developer_app_list" do
      subject { AndroidMarket.get_developer_app_list(developer_name, position, language) }

      it{ should array_instance_of AndroidMarketApplication }
    end
  end

  describe "use stub content" do
    include_context :use_stub_content
    it_behaves_like :android_market_base_examples
  end

  describe "use real content", :content => "real"  do
    #include_context :save_content
    it_behaves_like :android_market_base_examples
  end
end
