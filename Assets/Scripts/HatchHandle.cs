using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HatchHandle : MonoBehaviour
{
    [SerializeField]
    private Transform target;

    [SerializeField]
    private float speed = 1f;

    private Rigidbody rb;

    // Start is called before the first frame update
    void Start()
    {
        rb = GetComponent<Rigidbody>();
    }

    // Update is called once per frame
    void FixedUpdate()
    {
        //rb.MovePosition(target.transform.position);
        rb.MovePosition(transform.position + (target.position - transform.position).normalized * speed * Time.fixedDeltaTime);
        //transform.rotation = Quaternion.LookRotation(transform.forward, transform.position - target.position);
    }

    public void ResetHandler()
    {
        target.position = transform.position;
    }
}
