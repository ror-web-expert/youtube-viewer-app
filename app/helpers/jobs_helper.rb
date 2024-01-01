module JobsHelper
  def custom_sort_hash_with_alphabetically(hash)
    special_categories = ["Critical & Intensive Care", "Medical-Surgical", "Telemetry", "Emergency Medicine", "Surgery", "Surgical", "Perioperative Care"]

    special_categories_hash = hash.select { |key, _| special_categories.include?(key) }
    other_categories_hash = hash.reject { |key, _| special_categories.include?(key) }

    sorted_special_categories_hash = Hash[special_categories_hash.sort_by { |key, value| [-value, key.downcase] }]
    sorted_other_categories_hash = Hash[other_categories_hash.sort_by { |key, _| key.downcase }]

    sorted_special_categories_hash.merge(sorted_other_categories_hash)
  end
end
