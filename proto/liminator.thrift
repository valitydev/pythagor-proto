namespace java dev.vality.liminator
namespace erlang liminator.liminator

typedef i64 LimitId

/* Наименование лимита (например, limit.card.day.777) */
typedef string LimitName

/* ИД операции изменения значения (например, invoice.1) */
typedef string OperationId

typedef Map<String, String> Context

typedef i64 Value

/* Временная метка операции epochmills */
typedef i64 Timestamp

exception LimitNotFound {}
exception DuplicateLimitName {}

struct CreateLimitRequest {
    1: required LimitName limit_name
    2: required OperationId operation_id
    3: optional Context context
}

struct LimitRequest {
    1: required LimitName limit_name
    2: required OperationId operation_id
    3: required Value value
    4: optional Timestamp timestamp
}

struct LimitResponse {
    1: required LimitId id
    2: required LimitName limit_name
    3: required Value commit_value
    4: required Value hold_value
}

service LiminatorService {

    /* Создать счетчик для дальнейшего подсчета */
    LimitResponse create(CreateLimitRequest request) throws (1: DuplicateLimitName ex1)

    /* Добавить значение */
    list<LimitResponse> hold(list<LimitRequest> request) throws (1: LimitNotFound ex1)

    /* Применить значение */
    list<LimitResponse> commit(list<LimitRequest> request) throws (1: LimitNotFound ex1)

    /* Отменить добавление */
    list<LimitResponse> rollback(list<LimitRequest> request) throws (1: LimitNotFound ex1)

    /* Получить значение */
    list<LimitResponse> get(list<LimitName> limit_names) throws (1: LimitNotFound ex1)
}