import Foundation

func async(blocks: (() -> Void)..., then:(() -> Void)? = nil) {
    let queue = dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)
    let group = dispatch_group_create()
    blocks.forEach {
        dispatch_group_async(group, queue, $0)
    }
    guard let then = then else { return }
    dispatch_group_notify(group, queue, then)
}

func sync_main(block: (() -> Void)) {
    let queue = dispatch_get_main_queue()
    dispatch_sync(queue, block)
}
