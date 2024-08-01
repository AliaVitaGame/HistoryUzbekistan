using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Dem : MonoBehaviour
{
    [SerializeField] private Animator animator;
    [SerializeField] private Animator animato2;
    [SerializeField] private bool a;
    private void Start()
    {
        Cursor.lockState = CursorLockMode.Locked;   
    }
    private void Update()
    {
        Cursor.lockState = CursorLockMode.Locked;
        if (Input.GetMouseButtonDown(1))
        {
            animator.SetTrigger("Attack0");
            if(a)
            animator.applyRootMotion = true;
            animato2.SetBool("Attack", true);
        }
    }
}
