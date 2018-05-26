package com.sen.beans;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class UpLoadRecordExample {
    protected String orderByClause;

    protected boolean distinct;

    protected List<Criteria> oredCriteria;

    public UpLoadRecordExample() {
        oredCriteria = new ArrayList<Criteria>();
    }

    public void setOrderByClause(String orderByClause) {
        this.orderByClause = orderByClause;
    }

    public String getOrderByClause() {
        return orderByClause;
    }

    public void setDistinct(boolean distinct) {
        this.distinct = distinct;
    }

    public boolean isDistinct() {
        return distinct;
    }

    public List<Criteria> getOredCriteria() {
        return oredCriteria;
    }

    public void or(Criteria criteria) {
        oredCriteria.add(criteria);
    }

    public Criteria or() {
        Criteria criteria = createCriteriaInternal();
        oredCriteria.add(criteria);
        return criteria;
    }

    public Criteria createCriteria() {
        Criteria criteria = createCriteriaInternal();
        if (oredCriteria.size() == 0) {
            oredCriteria.add(criteria);
        }
        return criteria;
    }

    protected Criteria createCriteriaInternal() {
        Criteria criteria = new Criteria();
        return criteria;
    }

    public void clear() {
        oredCriteria.clear();
        orderByClause = null;
        distinct = false;
    }

    protected abstract static class GeneratedCriteria {
        protected List<Criterion> criteria;

        protected GeneratedCriteria() {
            super();
            criteria = new ArrayList<Criterion>();
        }

        public boolean isValid() {
            return criteria.size() > 0;
        }

        public List<Criterion> getAllCriteria() {
            return criteria;
        }

        public List<Criterion> getCriteria() {
            return criteria;
        }

        protected void addCriterion(String condition) {
            if (condition == null) {
                throw new RuntimeException("Value for condition cannot be null");
            }
            criteria.add(new Criterion(condition));
        }

        protected void addCriterion(String condition, Object value, String property) {
            if (value == null) {
                throw new RuntimeException("Value for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value));
        }

        protected void addCriterion(String condition, Object value1, Object value2, String property) {
            if (value1 == null || value2 == null) {
                throw new RuntimeException("Between values for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value1, value2));
        }

        public Criteria andUpIdIsNull() {
            addCriterion("up_id is null");
            return (Criteria) this;
        }

        public Criteria andUpIdIsNotNull() {
            addCriterion("up_id is not null");
            return (Criteria) this;
        }

        public Criteria andUpIdEqualTo(Integer value) {
            addCriterion("up_id =", value, "upId");
            return (Criteria) this;
        }

        public Criteria andUpIdNotEqualTo(Integer value) {
            addCriterion("up_id <>", value, "upId");
            return (Criteria) this;
        }

        public Criteria andUpIdGreaterThan(Integer value) {
            addCriterion("up_id >", value, "upId");
            return (Criteria) this;
        }

        public Criteria andUpIdGreaterThanOrEqualTo(Integer value) {
            addCriterion("up_id >=", value, "upId");
            return (Criteria) this;
        }

        public Criteria andUpIdLessThan(Integer value) {
            addCriterion("up_id <", value, "upId");
            return (Criteria) this;
        }

        public Criteria andUpIdLessThanOrEqualTo(Integer value) {
            addCriterion("up_id <=", value, "upId");
            return (Criteria) this;
        }

        public Criteria andUpIdIn(List<Integer> values) {
            addCriterion("up_id in", values, "upId");
            return (Criteria) this;
        }

        public Criteria andUpIdNotIn(List<Integer> values) {
            addCriterion("up_id not in", values, "upId");
            return (Criteria) this;
        }

        public Criteria andUpIdBetween(Integer value1, Integer value2) {
            addCriterion("up_id between", value1, value2, "upId");
            return (Criteria) this;
        }

        public Criteria andUpIdNotBetween(Integer value1, Integer value2) {
            addCriterion("up_id not between", value1, value2, "upId");
            return (Criteria) this;
        }

        public Criteria andUpFilenameIsNull() {
            addCriterion("up_filename is null");
            return (Criteria) this;
        }

        public Criteria andUpFilenameIsNotNull() {
            addCriterion("up_filename is not null");
            return (Criteria) this;
        }

        public Criteria andUpFilenameEqualTo(String value) {
            addCriterion("up_filename =", value, "upFilename");
            return (Criteria) this;
        }

        public Criteria andUpFilenameNotEqualTo(String value) {
            addCriterion("up_filename <>", value, "upFilename");
            return (Criteria) this;
        }

        public Criteria andUpFilenameGreaterThan(String value) {
            addCriterion("up_filename >", value, "upFilename");
            return (Criteria) this;
        }

        public Criteria andUpFilenameGreaterThanOrEqualTo(String value) {
            addCriterion("up_filename >=", value, "upFilename");
            return (Criteria) this;
        }

        public Criteria andUpFilenameLessThan(String value) {
            addCriterion("up_filename <", value, "upFilename");
            return (Criteria) this;
        }

        public Criteria andUpFilenameLessThanOrEqualTo(String value) {
            addCriterion("up_filename <=", value, "upFilename");
            return (Criteria) this;
        }

        public Criteria andUpFilenameLike(String value) {
            addCriterion("up_filename like", value, "upFilename");
            return (Criteria) this;
        }

        public Criteria andUpFilenameNotLike(String value) {
            addCriterion("up_filename not like", value, "upFilename");
            return (Criteria) this;
        }

        public Criteria andUpFilenameIn(List<String> values) {
            addCriterion("up_filename in", values, "upFilename");
            return (Criteria) this;
        }

        public Criteria andUpFilenameNotIn(List<String> values) {
            addCriterion("up_filename not in", values, "upFilename");
            return (Criteria) this;
        }

        public Criteria andUpFilenameBetween(String value1, String value2) {
            addCriterion("up_filename between", value1, value2, "upFilename");
            return (Criteria) this;
        }

        public Criteria andUpFilenameNotBetween(String value1, String value2) {
            addCriterion("up_filename not between", value1, value2, "upFilename");
            return (Criteria) this;
        }

        public Criteria andUpFileTypeIsNull() {
            addCriterion("up_file_type is null");
            return (Criteria) this;
        }

        public Criteria andUpFileTypeIsNotNull() {
            addCriterion("up_file_type is not null");
            return (Criteria) this;
        }

        public Criteria andUpFileTypeEqualTo(String value) {
            addCriterion("up_file_type =", value, "upFileType");
            return (Criteria) this;
        }

        public Criteria andUpFileTypeNotEqualTo(String value) {
            addCriterion("up_file_type <>", value, "upFileType");
            return (Criteria) this;
        }

        public Criteria andUpFileTypeGreaterThan(String value) {
            addCriterion("up_file_type >", value, "upFileType");
            return (Criteria) this;
        }

        public Criteria andUpFileTypeGreaterThanOrEqualTo(String value) {
            addCriterion("up_file_type >=", value, "upFileType");
            return (Criteria) this;
        }

        public Criteria andUpFileTypeLessThan(String value) {
            addCriterion("up_file_type <", value, "upFileType");
            return (Criteria) this;
        }

        public Criteria andUpFileTypeLessThanOrEqualTo(String value) {
            addCriterion("up_file_type <=", value, "upFileType");
            return (Criteria) this;
        }

        public Criteria andUpFileTypeLike(String value) {
            addCriterion("up_file_type like", value, "upFileType");
            return (Criteria) this;
        }

        public Criteria andUpFileTypeNotLike(String value) {
            addCriterion("up_file_type not like", value, "upFileType");
            return (Criteria) this;
        }

        public Criteria andUpFileTypeIn(List<String> values) {
            addCriterion("up_file_type in", values, "upFileType");
            return (Criteria) this;
        }

        public Criteria andUpFileTypeNotIn(List<String> values) {
            addCriterion("up_file_type not in", values, "upFileType");
            return (Criteria) this;
        }

        public Criteria andUpFileTypeBetween(String value1, String value2) {
            addCriterion("up_file_type between", value1, value2, "upFileType");
            return (Criteria) this;
        }

        public Criteria andUpFileTypeNotBetween(String value1, String value2) {
            addCriterion("up_file_type not between", value1, value2, "upFileType");
            return (Criteria) this;
        }

        public Criteria andUpUrlIsNull() {
            addCriterion("up_url is null");
            return (Criteria) this;
        }

        public Criteria andUpUrlIsNotNull() {
            addCriterion("up_url is not null");
            return (Criteria) this;
        }

        public Criteria andUpUrlEqualTo(String value) {
            addCriterion("up_url =", value, "upUrl");
            return (Criteria) this;
        }

        public Criteria andUpUrlNotEqualTo(String value) {
            addCriterion("up_url <>", value, "upUrl");
            return (Criteria) this;
        }

        public Criteria andUpUrlGreaterThan(String value) {
            addCriterion("up_url >", value, "upUrl");
            return (Criteria) this;
        }

        public Criteria andUpUrlGreaterThanOrEqualTo(String value) {
            addCriterion("up_url >=", value, "upUrl");
            return (Criteria) this;
        }

        public Criteria andUpUrlLessThan(String value) {
            addCriterion("up_url <", value, "upUrl");
            return (Criteria) this;
        }

        public Criteria andUpUrlLessThanOrEqualTo(String value) {
            addCriterion("up_url <=", value, "upUrl");
            return (Criteria) this;
        }

        public Criteria andUpUrlLike(String value) {
            addCriterion("up_url like", value, "upUrl");
            return (Criteria) this;
        }

        public Criteria andUpUrlNotLike(String value) {
            addCriterion("up_url not like", value, "upUrl");
            return (Criteria) this;
        }

        public Criteria andUpUrlIn(List<String> values) {
            addCriterion("up_url in", values, "upUrl");
            return (Criteria) this;
        }

        public Criteria andUpUrlNotIn(List<String> values) {
            addCriterion("up_url not in", values, "upUrl");
            return (Criteria) this;
        }

        public Criteria andUpUrlBetween(String value1, String value2) {
            addCriterion("up_url between", value1, value2, "upUrl");
            return (Criteria) this;
        }

        public Criteria andUpUrlNotBetween(String value1, String value2) {
            addCriterion("up_url not between", value1, value2, "upUrl");
            return (Criteria) this;
        }

        public Criteria andUpUserNameIsNull() {
            addCriterion("up_user_name is null");
            return (Criteria) this;
        }

        public Criteria andUpUserNameIsNotNull() {
            addCriterion("up_user_name is not null");
            return (Criteria) this;
        }

        public Criteria andUpUserNameEqualTo(String value) {
            addCriterion("up_user_name =", value, "upUserName");
            return (Criteria) this;
        }

        public Criteria andUpUserNameNotEqualTo(String value) {
            addCriterion("up_user_name <>", value, "upUserName");
            return (Criteria) this;
        }

        public Criteria andUpUserNameGreaterThan(String value) {
            addCriterion("up_user_name >", value, "upUserName");
            return (Criteria) this;
        }

        public Criteria andUpUserNameGreaterThanOrEqualTo(String value) {
            addCriterion("up_user_name >=", value, "upUserName");
            return (Criteria) this;
        }

        public Criteria andUpUserNameLessThan(String value) {
            addCriterion("up_user_name <", value, "upUserName");
            return (Criteria) this;
        }

        public Criteria andUpUserNameLessThanOrEqualTo(String value) {
            addCriterion("up_user_name <=", value, "upUserName");
            return (Criteria) this;
        }

        public Criteria andUpUserNameLike(String value) {
            addCriterion("up_user_name like", value, "upUserName");
            return (Criteria) this;
        }

        public Criteria andUpUserNameNotLike(String value) {
            addCriterion("up_user_name not like", value, "upUserName");
            return (Criteria) this;
        }

        public Criteria andUpUserNameIn(List<String> values) {
            addCriterion("up_user_name in", values, "upUserName");
            return (Criteria) this;
        }

        public Criteria andUpUserNameNotIn(List<String> values) {
            addCriterion("up_user_name not in", values, "upUserName");
            return (Criteria) this;
        }

        public Criteria andUpUserNameBetween(String value1, String value2) {
            addCriterion("up_user_name between", value1, value2, "upUserName");
            return (Criteria) this;
        }

        public Criteria andUpUserNameNotBetween(String value1, String value2) {
            addCriterion("up_user_name not between", value1, value2, "upUserName");
            return (Criteria) this;
        }

        public Criteria andUpTimeIsNull() {
            addCriterion("up_time is null");
            return (Criteria) this;
        }

        public Criteria andUpTimeIsNotNull() {
            addCriterion("up_time is not null");
            return (Criteria) this;
        }

        public Criteria andUpTimeEqualTo(Date value) {
            addCriterion("up_time =", value, "upTime");
            return (Criteria) this;
        }

        public Criteria andUpTimeNotEqualTo(Date value) {
            addCriterion("up_time <>", value, "upTime");
            return (Criteria) this;
        }

        public Criteria andUpTimeGreaterThan(Date value) {
            addCriterion("up_time >", value, "upTime");
            return (Criteria) this;
        }

        public Criteria andUpTimeGreaterThanOrEqualTo(Date value) {
            addCriterion("up_time >=", value, "upTime");
            return (Criteria) this;
        }

        public Criteria andUpTimeLessThan(Date value) {
            addCriterion("up_time <", value, "upTime");
            return (Criteria) this;
        }

        public Criteria andUpTimeLessThanOrEqualTo(Date value) {
            addCriterion("up_time <=", value, "upTime");
            return (Criteria) this;
        }

        public Criteria andUpTimeIn(List<Date> values) {
            addCriterion("up_time in", values, "upTime");
            return (Criteria) this;
        }

        public Criteria andUpTimeNotIn(List<Date> values) {
            addCriterion("up_time not in", values, "upTime");
            return (Criteria) this;
        }

        public Criteria andUpTimeBetween(Date value1, Date value2) {
            addCriterion("up_time between", value1, value2, "upTime");
            return (Criteria) this;
        }

        public Criteria andUpTimeNotBetween(Date value1, Date value2) {
            addCriterion("up_time not between", value1, value2, "upTime");
            return (Criteria) this;
        }

        public Criteria andUpSnoIsNull() {
            addCriterion("up_sno is null");
            return (Criteria) this;
        }

        public Criteria andUpSnoIsNotNull() {
            addCriterion("up_sno is not null");
            return (Criteria) this;
        }

        public Criteria andUpSnoEqualTo(String value) {
            addCriterion("up_sno =", value, "upSno");
            return (Criteria) this;
        }

        public Criteria andUpSnoNotEqualTo(String value) {
            addCriterion("up_sno <>", value, "upSno");
            return (Criteria) this;
        }

        public Criteria andUpSnoGreaterThan(String value) {
            addCriterion("up_sno >", value, "upSno");
            return (Criteria) this;
        }

        public Criteria andUpSnoGreaterThanOrEqualTo(String value) {
            addCriterion("up_sno >=", value, "upSno");
            return (Criteria) this;
        }

        public Criteria andUpSnoLessThan(String value) {
            addCriterion("up_sno <", value, "upSno");
            return (Criteria) this;
        }

        public Criteria andUpSnoLessThanOrEqualTo(String value) {
            addCriterion("up_sno <=", value, "upSno");
            return (Criteria) this;
        }

        public Criteria andUpSnoLike(String value) {
            addCriterion("up_sno like", value, "upSno");
            return (Criteria) this;
        }

        public Criteria andUpSnoNotLike(String value) {
            addCriterion("up_sno not like", value, "upSno");
            return (Criteria) this;
        }

        public Criteria andUpSnoIn(List<String> values) {
            addCriterion("up_sno in", values, "upSno");
            return (Criteria) this;
        }

        public Criteria andUpSnoNotIn(List<String> values) {
            addCriterion("up_sno not in", values, "upSno");
            return (Criteria) this;
        }

        public Criteria andUpSnoBetween(String value1, String value2) {
            addCriterion("up_sno between", value1, value2, "upSno");
            return (Criteria) this;
        }

        public Criteria andUpSnoNotBetween(String value1, String value2) {
            addCriterion("up_sno not between", value1, value2, "upSno");
            return (Criteria) this;
        }
    }

    public static class Criteria extends GeneratedCriteria {

        protected Criteria() {
            super();
        }
    }

    public static class Criterion {
        private String condition;

        private Object value;

        private Object secondValue;

        private boolean noValue;

        private boolean singleValue;

        private boolean betweenValue;

        private boolean listValue;

        private String typeHandler;

        public String getCondition() {
            return condition;
        }

        public Object getValue() {
            return value;
        }

        public Object getSecondValue() {
            return secondValue;
        }

        public boolean isNoValue() {
            return noValue;
        }

        public boolean isSingleValue() {
            return singleValue;
        }

        public boolean isBetweenValue() {
            return betweenValue;
        }

        public boolean isListValue() {
            return listValue;
        }

        public String getTypeHandler() {
            return typeHandler;
        }

        protected Criterion(String condition) {
            super();
            this.condition = condition;
            this.typeHandler = null;
            this.noValue = true;
        }

        protected Criterion(String condition, Object value, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.typeHandler = typeHandler;
            if (value instanceof List<?>) {
                this.listValue = true;
            } else {
                this.singleValue = true;
            }
        }

        protected Criterion(String condition, Object value) {
            this(condition, value, null);
        }

        protected Criterion(String condition, Object value, Object secondValue, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.secondValue = secondValue;
            this.typeHandler = typeHandler;
            this.betweenValue = true;
        }

        protected Criterion(String condition, Object value, Object secondValue) {
            this(condition, value, secondValue, null);
        }
    }
}