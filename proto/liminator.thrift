namespace java dev.vality.liminator
namespace erlang liminator.liminator

typedef i64 LimitId

/* Наименование лимита (например, limit.card.day.777) */
typedef string LimitName

/* ИД операции изменения значения (например, invoice.1) */
typedef string OperationId

typedef map<string, string> Context

typedef i64 Value

/* Временная метка операции epochmills */
typedef i64 Timestamp

exception LimitNotFound {}
exception OperationNotFound {}
exception OperationAlreadyInFinalState {}
exception DuplicateOperation {}
exception DuplicateLimitName {}
exception LimitsValuesReadingException {}

struct CreateLimitRequest {
    1: required LimitName limit_name
    2: optional Context context
}

struct LimitRequest {
    1: required OperationId operation_id
    2: required Value value
    3: required list<LimitName> limit_names
}

struct LimitResponse {
    1: required LimitName limit_name
    2: required Value commit_value
    3: required Value hold_value
}

service LiminatorService {

    /* Создать счетчик для дальнейшего подсчета */
    LimitResponse Create(CreateLimitRequest request) throws (1: DuplicateLimitName ex1)

    /* Добавить значение */
    list<LimitResponse> Hold(LimitRequest request)
        throws (1: LimitNotFound ex1, 2: DuplicateOperation ex2, 3: OperationAlreadyInFinalState ex3)

    /* Применить значение */
    void Commit(LimitRequest request) throws (1: LimitNotFound ex1, 2: OperationNotFound ex2)

    /* Отменить добавление */
    void Rollback(LimitRequest request) throws (1: LimitNotFound ex1, 2: OperationNotFound ex2)

    /* Получить значения лимитов */
    list<LimitResponse> Get(LimitRequest request) throws (1: LimitNotFound ex1, 2: LimitsValuesReadingException ex2)

    /* Получить актуальные значения лимитов на текущий момент */
    list<LimitResponse> GetLastLimitsValues(list<LimitName> limit_names)
        throws (1: LimitNotFound ex1, 2: LimitsValuesReadingException ex2)
}