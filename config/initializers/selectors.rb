VALLEY_WISE_HEALTH = {
  "listing_selector": {
    "job-container-list": "ul .result-item",
    "main_selector": {
      "title": ".item-title a",
      "source_url": ".item-title a"
    },
    "pagination": {
      "next_button": "a.page-link-next:not([aria-disabled='true'])"
    },
    "response_selector": {
      "location": ".item-title .location",
      "state": ".item-title .city-state"
    }
  },
  "detail_selector": {
    "job-detail-container": ".content",
    "response_selector": {
      "title": ".job-title",
      "facility": ".job-description-content p:contains('Facility:')",
      "department": ".job-description-content p:contains('Department:')",
      "schedule": ".job-description-content p:contains('Schedule:')",
      "shift_type": ".job-description-content p:contains('Shifts:')",
      "apply_now_url": ".job-addl-info .ApplyButton",
      "salary_range": ".job-addl-info .job-payrange",
      "posted_date": ".job-addl-info .date span",
      "job_status": ".job-addl-info .job-status span",
      "job_refernce_id": ".job-addl-info .job-ref",
      "description_raw_html": {
        "get_paragraph": ".job-description-content #descHeader",
        "next_element": true,
        "inner_html": true
      }
    }
  }
}

THRIVE_SPC = {
  "listing_selector": {
    "job-container-list": "#careers .career-card",
    "main_selector": {
      "title": ".career-details a",
      "source_url": ".career-details a"
    },
    "scrolling": {
      "scroll_count": "7"
    },
    "response_selector": {
      "location": ".career-details .blue"
    }
  },
  "detail_selector": {
    "job-detail-container": ".is-multiline",
    "response_selector": {
      "job_type": ".job-content p:contains('Full Time')",
      "description_raw_html": ".column[1]",
      "get_from_content": ".job-content"
    }
  }
}

HONOR_HEALTH = {
  "listing_selector": {
    "job-container-list": ".job-results-container .mat-expansion-panel",
    "main_selector": {
      "title": ".job-title a",
      "source_url": ".job-title a"
    },
    "pagination": {
      "next_button": ".mat-paginator-range-actions .mat-paginator-navigation-next:not([disabled='true'])"
    },
    "response_selector": {
      "location": ".job-result__location .label-container",
      "job_type": ".description-container .tags2",
      "working_hours": ".job-card-result-container .tags4"
    }
  },
  "detail_selector": {
    "job-detail-container": ".job-description-container",
    "response_selector": {
      "title": ".columns .left .header-section h1",
      "facility": "ul.meta-data-options li[1] span",
      "category": "ul.meta-data-options li[2] span",
      "department": "ul.meta-data-options li[5] span",
      "schedule": "ul.meta-data-options li[4] span",
      "shift_type": "ul.meta-data-options li[3] span",
      "Req Id": "ul.meta-data-options li[6] span",
      "apply_now_url": ".right .sticky-item .apply",
      "job_refernce_id": "ul.meta-data-options li[6] span",
      "job_description_heading": ".columns .left .main-description-section h2",
      "description_raw_html": ".columns .left .main-description-body"
    }
  }
}

MAYO_CLINIC = {
  "listing_selector": {
    "cookies_modal": {
      "id": "#system-ialert-button",
      "button_text": "Accept"
    },
    "job-container-list": "#search-results-list ul[2] li",
    "main_selector": {
      "title": "a",
      "source_url": "a"
    },
    "pagination_show_all": {
      "show_all_button": "#pagination-bottom .pagination-show-all"
    },
    "response_selector": {
      "location": ".job-location"
    }
  },
  "detail_selector": {
    "cookies_modal": {
      "id": ".system-ialert-button",
      "button_text": "Accept"
    },
    "job-detail-container": "#content",
    "response_selector": {
      "title": ".job-description .title-wrapper h2",
      "job_refernce_id": ".job-description .title-wrapper .job-id",
      "job_type": ".other-stuff li[2]",
      "department": ".deets p[4]",
      "second_department": ".other-stuff li[3]",
      "location": ".job-description .title-wrapper .ico-location",
      "posted_date": ".job-description .title-wrapper .job-date",
      "apply_now_url": ".button-wrapper a.job-apply",
      "description_raw_html": "#core_jd-top",
      "salary_range": {
        "next_sibling": true,
        "next_element": "true",
        "element_css": "b:contains('Compensation Detail')"
      },
      "short_description": {
        "next_sibling": true,
        "next_element": "true",
        "element_css": "b:contains('Site Description')"
      }
    }
  }
}

COMMON_SPIRIT = {
  "listing_selector": {
    "job-container-list": "#search-results-list ul li",
    "cookies_modal": {
      "id": "#igdpr-button",
      "button_text": "Accept"
    },
    "main_selector": {
      "title": "a .job-information h2",
      "source_url": "a[1]"
    },
    "pagination": {
      "next_button": ".pagination-paging a.next:not([class='next disabled'])"
    },
    "response_selector": {
      "location": ".job-information .job-location",
      "department": ".job-information .job-department"
    }
  },
  "detail_selector": {
    "job-detail-container": "#content",
    "response_selector": {
      "department": ".ajd_overview__quick-facts .ajd_overview__quick-fact--department",
      "job_type": ".ajd_overview__quick-facts .ajd_overview__quick-fact--type",
      "schedule": ".job-details-info .job-date[5]",
      "shift_type": ".job-details-info span[4]",
      "apply_now_url": ".ajd_header__job-buttons a",
      "job_refernce_id": ".job-details-info .job-id",
      "get_from_content": ".job-info",
      "description_raw_html": "#anchor-responsibilities .collapse-ajd__wrapper"
    }
  }
}

USPI = {
  "listing_selector": {
    "job-container-list": "#search-results-list ul li",
    "main_selector": {
      "title": "a h2",
      "source_url": "a"
    },
    "pagination_show_all": {
      "show_all_button": ".pagination-all .pagination-show-all"
    },
    "response_selector": {
      "location": ".job-location"
    }
  },
  "detail_selector": {
    "job-detail-container": ".job-description",
    "response_selector": {
      "facility": ".jd-job-info-wrap .job-facility",
      "location": ".jd-job-info-wrap .job-location",
      "apply_now_url": ".jd-btn-wrap .job-apply",
      "posted_date": ".jd-job-info-wrap .job-date",
      "job_refernce_id": ".jd-job-info-wrap .job-id",
      "description_raw_html": "#jd-wrap"
    }
  }
}

ENVITA = {
  "listing_selector": {
    "job-container-list": "#resumator-jobs .resumator-job",
    "main_selector": {
      "title": ".resumator-job-title",
      "source_url": ".resumator-job-view-details a"
    },
    "response_selector": {
      "location": ".resumator-job-info"
    }
  },
  "detail_selector": {
    "job-detail-container": "main",
    "response_selector": {
      "job_type": ".job-attributes-container #resumator-job-employment",
      "location": ".job-attributes-container div[1]",
      "schedule": ".job-details #job-description p[5]",
      "salary_range": ".job-details #job-description p[3]",
      "description_raw_html": ".job-details #job-description"
    }
  }
}

FRESENIUS_MEDICAL_CARE = {
  "listing_selector": {
    "job-container-list": ".sc-htpNat .sc-TuwoP",
    "main_selector": {
      "title": "div[1] a",
      "source_url": "div[1] a"
    },
    "response_selector": {
      "location": "div[1] .richText"
    },
    "pagination": {
      "next_button": "#JobSearchResultsWrapper a .sc-epGmkI button.sc-dphlzf.fQTloK:not([disabled]",
      next_button_text: ">>"
    },
  },
  "detail_selector": {
    "job-detail-container": ".hSHIcX",
    "response_selector": {
      "job_type": "#JobDetailOverview div[6] .kowrXr",
      "location": ".logoPrintable span[1]",
      "apply_now_url": ".jd-btn-wrap .job-apply",
      "department": "#JobDetailOverview div[7] .kowrXr",
      "job_refernce_id": "#JobDetailOverview div[8] .kowrXr",
      "description_raw_html": "#JobDetailDescription"
    }
  }
}

IQVIA = {
  "listing_selector": {
    "job-container-list": "#search-results-list li",
    "main_selector": {
      "title": "a h2",
      "source_url": "a"
    },
    "response_selector": {
      "location": "a .job-info-wrap .job-location"
    }
  },
  "detail_selector": {
    "job-detail-container": ".job-description",
    "response_selector": {
      "job_type": ".jd-jobinfo .job-type",
      "job_refernce_id": ".jd-jobinfo .job-id",
      "apply_now_url": ".jd-jobinfo-wrap a",
      "description_raw_html": ".ats-description"
    }
  }
}

LIFE_POINT_HEALTH = {
  "listing_selector": {
    "job-container-list": "#search-results-list li",
    "main_selector": {
      "title": "a h2",
      "source_url": "a"
    },
    "response_selector": {
      "location": "a .job-location"
    }
  },
  "detail_selector": {
    "job-detail-container": ".job-description",
    "response_selector": {
      "job_refernce_id": ".job-info__wrap .job-id",
      "facility": ".job-info__wrap .job-brand",
      "category": ".job-info__wrap .job-cat",
      "apply_now_url": ".job-buttons .job-apply",
      "description_raw_html": ".read-more .ats-description"
    }
  }
}

BLUE_MOUNTAIN_HOSPITAL = {
  "listing_selector": {
    "job-container-list": "#pt-cv-gls-R .pt-cv-content-item",
    "main_selector": {
      "title": ".pt-cv-ifield .pt-cv-title a",
      "source_url": ".pt-cv-ifield .pt-cv-title a"
    },
    "response_selector": {
      "location": "a .job-location"
    }
  },
  "detail_selector": {
    "job-detail-container": ".entry-wrap",
    "response_selector": {
      "apply_now_url": ".wp-block-button a",
      "get_from_content": ".entry-header h1",
      "description_raw_html": ".entry-content"
    }
  }
}

MGA_HOME_CARE = {
  "listing_selector": {
    "job-container-list": ".job-listing .joblist",
    "main_selector": {
      "title": ".job-title",
      "source_url": ".job-title a"
    },
    "response_selector": {
      "location": ".job-location"
    }
  },
  "detail_selector": {
    "job-detail-container": ".job-content .cl-left",
    "response_selector": {
      "job_type": ".job-type",
      "apply_now_url": ".w-btn-wrapper a",
      "shift_type": ".company-description ul[1] li[4]",
      "description_raw_html": ".job-sections .company-description"
    }
  }
}

CVS_HEALTH = {
  "listing_selector": {
    "job-container-list": "#widget-jobsearch-results-list .job",
    "main_selector": {
      "title": ".jobTitle a",
      "source_url": ".jobTitle a"
    },
    "pagination": {
      "next_button": "#widget-jobsearch-results-pages .pagination-li a:not([disabled]",
      next_button_text: ">>"
    },
    "response_selector": {
      "location": ".joblist-location .job-locale",
      "job_refernce_id": ".job-innerwrap.g-cols div[3]"
    }
  },
  "detail_selector": {
    "job-detail-container": ".post-content .fusion-layout-column.fusion_builder_column.fusion-builder-column-5",
    "response_selector": {
      "apply_now_url": ".fusion-text.fusion-text-2 a.apply-btn",
      "get_from_content": ".fusion-text.fusion-text-3",
      "description_raw_html": ".fusion-text.fusion-text-3"
    }
  }
}

ATLAS_HEALTH = {
  "listing_selector": {
    "job-container-list": "#jobsect .pfc-jl .entry-categories",
    "main_selector": {
      "title": ".joblinks",
      "source_url": ".joblinks"
    },
    "pagination": {
      "next_button": ".pagination .facetwp-pager a:not([disabled]",
      next_button_text: ">>"
    },
    "response_selector": {
      "location": ".joblinks .loc-stuff",
    }
  },
  "detail_selector": {
    "job-detail-container": ".job-desc",
    "response_selector": {
      "apply_now_url": ".applyjd",
      "get_from_content": ".oculusStuff",
      "description_raw_html": ".oculusStuff"
    }
  }
}
