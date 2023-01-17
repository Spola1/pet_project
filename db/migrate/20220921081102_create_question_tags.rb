class CreateQuestionTags < ActiveRecord::Migration[7.0]
  def change
    create_table :question_tags do |t|
      t.belongs_to :question, null: false, foreign_key: { on_delete: :cascade }
      t.belongs_to :tag, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end

    add_index :question_tags, [:question_id, :tag_id], unique: true
  end
end
