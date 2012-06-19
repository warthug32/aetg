# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120619074910) do

  create_table "abouts", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.date     "publish_date"
    t.string   "last_updated_by"
    t.string   "locale"
    t.boolean  "activate"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "article_categories", :force => true do |t|
    t.string   "name"
    t.string   "name_zh"
    t.string   "name_gb"
    t.string   "last_updated_by"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.date     "publish_date"
    t.string   "last_updated_by"
    t.string   "author"
    t.text     "tag"
    t.string   "locale"
    t.boolean  "activate"
    t.text     "short_description"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "browser_url"
    t.integer  "article_category_id"
    t.integer  "member_id"
    t.boolean  "highlight"
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
  end

  create_table "banners", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.date     "publish_date"
    t.string   "last_updated_by"
    t.text     "tag"
    t.string   "banner_file_name"
    t.string   "banner_content_type"
    t.integer  "banner_file_size"
    t.string   "locale"
    t.boolean  "activate"
    t.text     "url"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "branches", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.text     "address"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "gmaps"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "telephone"
    t.string   "fax"
    t.string   "locale"
    t.boolean  "activate"
  end

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "fax"
    t.string   "phone"
    t.string   "address"
    t.text     "description"
    t.string   "locale"
    t.string   "last_updated_by"
    t.date     "publish_date"
    t.boolean  "activate"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "contacts", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.date     "publish_date"
    t.string   "last_updated_by"
    t.string   "locale"
    t.boolean  "activate"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "content_images", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.text     "content"
    t.date     "publish_date"
    t.string   "last_updated_by"
    t.string   "content_image_file_name"
    t.string   "content_image_content_type"
    t.integer  "content_image_file_size"
    t.string   "page_id"
    t.integer  "display_order"
    t.string   "locale"
    t.boolean  "activate"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.string   "url"
  end

  create_table "design_templates", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "districts", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "educategories", :force => true do |t|
    t.string   "name"
    t.string   "name_zh"
    t.string   "name_gb"
    t.string   "last_updated_by"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "enquiries", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.text     "message"
    t.string   "phone"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "events", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.date     "publish_date"
    t.string   "last_updated_by"
    t.date     "start_date"
    t.date     "end_date"
    t.text     "tag"
    t.string   "locale"
    t.boolean  "activate"
    t.text     "short_description"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "browser_url"
    t.boolean  "highlight"
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
  end

  create_table "industries", :force => true do |t|
    t.string   "name"
    t.string   "name_zh"
    t.string   "name_gb"
    t.string   "last_updated_by"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "job_applications", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "job_classifications", :force => true do |t|
    t.string   "name"
    t.string   "last_updated_by"
    t.string   "locale"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "job_industries", :force => true do |t|
    t.string   "name"
    t.string   "last_updated_by"
    t.string   "locale"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "job_posts", :force => true do |t|
    t.string   "position"
    t.string   "reference_code"
    t.string   "location"
    t.integer  "work_type"
    t.float    "salary1"
    t.float    "salary2"
    t.integer  "job_industry_id"
    t.integer  "job_classification_id"
    t.integer  "company_id"
    t.text     "description"
    t.text     "requirements"
    t.string   "locale"
    t.string   "last_updated_by"
    t.boolean  "activate"
    t.date     "publish_date"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "links", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "locales", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "members", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "title"
    t.string   "first_name"
    t.string   "last_name"
    t.text     "address"
    t.string   "telephone"
    t.text     "website"
    t.datetime "created_at",                                            :null => false
    t.datetime "updated_at",                                            :null => false
    t.string   "role"
    t.string   "resume_file_name"
    t.string   "resume_content_type"
    t.integer  "resume_file_size"
    t.string   "cv_file_name"
    t.string   "cv_content_type"
    t.integer  "cv_file_size"
    t.text     "country"
    t.string   "gender"
    t.date     "date_of_brith"
    t.string   "mobile"
  end

  add_index "members", ["confirmation_token"], :name => "index_members_on_confirmation_token", :unique => true
  add_index "members", ["email"], :name => "index_members_on_email", :unique => true
  add_index "members", ["reset_password_token"], :name => "index_members_on_reset_password_token", :unique => true

  create_table "natures", :force => true do |t|
    t.string   "name"
    t.string   "name_zh"
    t.string   "name_gb"
    t.string   "last_updated_by"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "news", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.date     "publish_date"
    t.string   "last_updated_by"
    t.string   "author"
    t.text     "tag"
    t.string   "locale"
    t.boolean  "activate"
    t.text     "short_description"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "browser_url"
    t.boolean  "highlight"
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
  end

  create_table "pages", :force => true do |t|
    t.string   "page_title"
    t.string   "browser_title"
    t.string   "page_url"
    t.text     "body"
    t.text     "link_forward"
    t.integer  "page_id"
    t.string   "locale"
    t.string   "banner_file_name"
    t.string   "banner_content_type"
    t.integer  "banner_file_size"
    t.text     "tag"
    t.string   "last_updated_by"
    t.date     "publish_date"
    t.text     "short_body"
    t.boolean  "activate"
    t.boolean  "isSkip"
    t.boolean  "show_in_menu"
    t.string   "design_template"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "display_order"
  end

  create_table "partners", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.date     "publish_date"
    t.string   "last_updated_by"
    t.text     "tag"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.string   "locale"
    t.boolean  "activate"
    t.text     "url"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "positions", :force => true do |t|
    t.string   "name"
    t.string   "locale"
    t.string   "last_updated_by"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "product_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "locale"
    t.string   "last_updated_by"
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.date     "publish_date"
    t.string   "last_updated_by"
    t.text     "tag"
    t.string   "locale"
    t.boolean  "activate"
    t.string   "browser_title"
    t.integer  "product_category_id"
    t.integer  "stock"
    t.float    "price"
    t.boolean  "isDiscount"
    t.float    "discounted_price"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "project_videos", :force => true do |t|
    t.string   "title"
    t.text     "tag"
    t.string   "last_updated_by"
    t.text     "video_url"
    t.boolean  "activate"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "seos", :force => true do |t|
    t.text     "meta_description"
    t.text     "meta_author"
    t.text     "meta_keywords"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "teams", :force => true do |t|
    t.string   "first_name"
    t.string   "middle_initial"
    t.string   "last_name"
    t.string   "position"
    t.string   "page_url"
    t.text     "brief_intro"
    t.text     "body"
    t.string   "phone_direct"
    t.string   "mobile_no"
    t.string   "email"
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
    t.string   "locale"
    t.string   "last_updated_by"
    t.date     "publish_date"
    t.boolean  "activate"
    t.integer  "display_order"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "topbanners", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.date     "publish_date"
    t.string   "last_updated_by"
    t.text     "tag"
    t.string   "banner_file_name"
    t.string   "banner_content_type"
    t.integer  "banner_file_size"
    t.string   "locale"
    t.boolean  "activate"
    t.text     "url"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "hashed_password"
    t.string   "role"
    t.text     "address"
    t.string   "district_id"
    t.string   "phone"
    t.boolean  "status"
    t.date     "last_login_at"
    t.string   "last_ip"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "work_types", :force => true do |t|
    t.string "name"
    t.string "locale"
  end

end
